require 'coderay'
require 'launchy'

class Water
  DIFF_FILE_NAME = 'diff.html'
  
  def self.run
    new.run
  end
  
  def run
    @diff = ARGF.read
    
    if @diff.chomp.empty?
      puts 'Your diff is empty.'
    else
      write_diff_file
      open_diff_file
    end
  end
  
  def write_diff_file
    # FIXME: Don't just write into the current folder.
    File.open DIFF_FILE_NAME, 'w' do |file|
      file.write CodeRay.scan(@diff, :diff).page(:title => 'diff | water')
    end
  end
  
  def open_diff_file
    Launchy.open "file://#{File.join Dir.pwd, DIFF_FILE_NAME}"
  end
end