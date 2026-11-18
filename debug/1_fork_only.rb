require "tmpdir"
Dir.mktmpdir("fx_reopen") do |d|
  out = File.join(d, "out")
  pid = fork do
    $stdout.reopen(out, "w")
    $stderr.reopen(File::NULL, "w")
    puts "child"
    warn "hidden"
    $stdout.flush
    exit!(0)
  end
  Process.wait(pid)
  p $?.exitstatus, File.read(out)
end
