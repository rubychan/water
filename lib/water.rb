require 'coderay'

module Water
  DIFF_FILE_NAME = 'diff.html'
  
  def self.run
    # FIXME: Don't just write into the currend folder.
    File.open DIFF_FILE_NAME, 'w' do |file|
      file.write CodeRay.scan(ARGF.read, :diff).page
    end
    
    # FIXME: Only works on Mac.
    %x{open #{DIFF_FILE_NAME}}
  end
end