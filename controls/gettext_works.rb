title 'Tests to confirm gettext works as expected'

plan_name = input('plan_name', value: 'gettext')
plan_ident = "#{ENV['HAB_ORIGIN']}/#{plan_name}"

control 'core-plans-gettext-works' do
  impact 1.0
  title 'Ensure gettext works as expected'
  desc '
  '
  gettext_path = command("hab pkg path #{plan_ident}")
  describe gettext_path do
    its('exit_status') { should eq 0 }
    its('stdout') { should_not be_empty }
  end
  
  gettext_pkg_ident = ((gettext_path.stdout.strip).match /(?<=pkgs\/)(.*)/)[1]
  describe command("DEBUG=true; hab pkg exec #{ gettext_pkg_ident} gettext --version") do
    its('exit_status') { should eq 0 }
    its('stdout') { should_not be_empty }
    its('stdout') { should match /gettext \(GNU gettext-runtime\) 0.20.1/ }
    its('stderr') { should be_empty }
  end
end
