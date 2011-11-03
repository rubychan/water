require 'coderay'
require 'launchy'

class Water
  DIFF_FILE_NAME = 'diff.html'
  
  def self.run
    new.run
  end
  
  def run
    diff = ARGF.read
    
    if diff.chomp.empty?
      puts 'Your diff is empty.'
    else
      write_diff_file diff
      open_diff_file
    end
  end
  
  def write_diff_file diff
    # FIXME: Don't just write into the current folder.
    File.open DIFF_FILE_NAME, 'w' do |file|
      file.write water(diff)
    end
  end
  
  def water diff
    output = diff.gsub(/\r\n?/, "\n").scan(/ (?> ^(?!-(?!--)|\+(?!\+\+)|[\\ ]|$|@@) .*\n)* (?> ^(?=-(?!--)|\+(?!\+\+)|[\\ ]|$|@@) .*(?:\n|\z))+ /x).map do |block|
      head_ray, content_ray = CodeRay.scanner(:diff).tokenize(block.split("\n", 2))
      content_ray ||= ''
      
      <<-HTML % [head_ray.div(:css => :class), content_ray.div(:css => :class)]
<div class="diff-block">
  <div class="diff-block-head">%s</div>
  <div class="diff-block-content">%s</div>
</div>
      HTML
    end.join("\n")
    
    output.extend(CodeRay::Encoders::HTML::Output)
    output.css = CodeRay::Encoders::HTML::CSS.new(:alpha)
    
    output.css.stylesheet << <<-CSS
    body {
      background: gray;
    }
    
    .diff-block {
      background: hsl(0,0%,95%);
      margin: 5px;
      margin-bottom: 0;
      padding: 3px 6px;
      overflow-y: visible;
      overflow-x: auto;
      -webkit-transition: 0.3s;
         -moz-transition: 0.3s;
              transition: 0.3s;
    }
    .diff-block.closed {
      margin-top: -5px;
      overflow: hidden;
    }
    .diff-block:first-of-type.closed {
      margin-top: 0;
    }
    
    .CodeRay pre {
      width: -moz-fit-content;
      line-height: 15px;
    }
    .CodeRay .line {
      float: none;
      height: 15px;
    }
    .diff-block-content .CodeRay .line {
      margin-bottom: -15px;
    }
    
    body > a {
      display: block;
      position: fixed;
      top: 0;
      right: 0;
      background: gray;
      color: white;
      padding: 5px 10px;
      font-family: monospace;
      font-weight: bold;
      text-decoration: none;
    }
    body > a:hover {
      text-decoration: underline;
    }
    CSS
    
    output.wrap_in! CodeRay::Encoders::HTML::Output.page_template_for_css(output.css)
    output.apply_title! 'diff | water'
    
    output[/<\/head>\s*<body>/] = <<-JS
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.6.4/jquery.min.js"></script>
    <script>
      $(function () {
        $('.diff-block').live('click', function () {
          $(this).toggleClass('closed').find('.diff-block-content').slideToggle('fast');
        });
        $('a.toggle-all').click(function () {
          $('.diff-block').toggleClass('closed').find('.diff-block-content').toggle();
        });
      })
    </script>
    </head>
    
    <body>
      <a href="#" class="toggle-all">toggle all</a>
    JS
    
    output
  end
  
  def open_diff_file
    Launchy.open "file://#{File.join Dir.pwd, DIFF_FILE_NAME}"
  end
end