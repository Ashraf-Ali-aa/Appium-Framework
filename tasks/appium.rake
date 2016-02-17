desc 'Run Appium'
task :run do
  node =  system("ps aux | grep ' node ' | grep -v grep")

  unless node
    FileUtils.rm('./appium.out') if File.exist?('appium.out')
    npm_exec 'appium > appium.out 2>&1 &'
    sleep 5
    node
  end
end

desc 'Start Appium console'
task :ark do
  Dir.chdir('feature/support/') { sh 'arc' }
end

def npm_exec(command)
  sh "PATH=$(npm bin):$PATH #{command}"
end
