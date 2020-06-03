title 'Tests to confirm gettext exists'

plan_name = input('plan_name', value: 'gettext')
plan_ident = "#{ENV['HAB_ORIGIN']}/#{plan_name}"
gettext_relative_path = input('command_path', value: '/bin/gettext')
gettext_installation_directory = command("hab pkg path #{plan_ident}")
gettext_full_path = gettext_installation_directory.stdout.strip + "#{ gettext_relative_path}"
 
control 'core-plans-gettext-exists' do
  impact 1.0
  title 'Ensure gettext exists'
  desc '
  '
   describe file(gettext_full_path) do
    it { should exist }
  end
end
