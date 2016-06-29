require 'spec_helper'
describe 'various' do

  context 'with defaults for all parameters' do
    it { should contain_class('various') }
  end
end
