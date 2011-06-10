require 'coderay'
require 'launchy'

module Water
  DIFF_FILE_NAME = 'diff.html'
  
  def self.run
    # FIXME: Don't just write into the currend folder.
    File.open DIFF_FILE_NAME, 'w' do |file|
      file.write CodeRay.scan(ARGF.read, :diff).page
    end
    
    url = "file://#{File.join Dir.pwd, DIFF_FILE_NAME}"
    Launchy.open url
  end
end