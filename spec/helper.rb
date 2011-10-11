$:.unshift(File.expand_path('../../lib', __FILE__))

require 'rubygems'
require 'bundler'

Bundler.require(:default, :development)

require 'pathname'
require 'logger'

root_path = Pathname(__FILE__).dirname.join('..').expand_path
lib_path  = root_path.join('lib')
log_path  = root_path.join('log')
log_path.mkpath

require 'adapter/spec/an_adapter'
require 'adapter/spec/json_adapter'
require 'adapter/spec/types'

require 'adapter-simpledb'

shared_examples_for "a SimpleDB adapter" do
  it_should_behave_like 'a json adapter'
end

logger = Logger.new(log_path.join('test.log'))
LogBuddy.init(:logger => logger)

RSpec.configure do |c|

end