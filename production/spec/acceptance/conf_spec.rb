require 'spec_helper_acceptance'

describe 'sysctl::conf' do

  describe 'running puppet code' do
    it 'should work with no errors' do
      pp = <<-EOS
        sysctl::conf { 'kernel.sem':
          value => '250 32000 100 128'
        }
        sysctl::conf { 'net.ipv4.tcp_syncookies':
          ensure => absent
        }
      EOS

      # Run it twice and test for idempotency
      apply_manifest(pp, :catch_failures => true)
      apply_manifest(pp, :catch_changes => true)
    end

    describe file '/etc/sysctl.conf' do
      it { is_expected.to be_file }
      its(:content) { should contain /kernel.sem/ }
    end

    describe file '/etc/sysctl.conf' do
      it { is_expected.to be_file }
      its(:content) { should_not contain /net.ipv4.tcp_syncookies/ }
    end

  end
end

