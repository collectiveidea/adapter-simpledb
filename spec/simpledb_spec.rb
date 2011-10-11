require 'helper'

describe "SimpleDB adapter" do
  before do
    raise "Set your S3_KEY and S3_SECRET" unless ENV['S3_KEY'] && ENV['S3_SECRET']
    @client = Fog::AWS::SimpleDB.new(
      :aws_access_key_id => ENV['S3_KEY'],
      :aws_secret_access_key => ENV['S3_SECRET']
    )
    
    @domain = 'adapter-simpledb-spec'
    # Need to use :consistent_read => true or we wil likely get failures
    @adapter = Adapter[:simpledb].new(@client, :domain => @domain, :consistent_read => true)
    @adapter.clear
  end

  let(:adapter) { @adapter }
  let(:client)  { @client }
  let(:domain)  { @domain }

  it_should_behave_like 'a SimpleDB adapter'

  it "stores arrays of multiple elements correctly" do
    adapter.write('foo', 'bacon' => ['chunky', 'tasty'])
    adapter.read('foo').should == {'bacon' => ['chunky', 'tasty']}
  end

  it "stores arrays of a single element correctly" do
    adapter.write('foo', 'bacon' => ['chunky'])
    adapter.read('foo').should == {'bacon' => ['chunky']}
  end

  it "stores an empty array correctly" do
    adapter.write('foo', 'bacon' => [])
    adapter.read('foo').should == {'bacon' => []}
  end
  
  it "replaces values instead of appending" do
    adapter.write('foo', 'bacon' => 'chunky')
    adapter.write('foo', 'bacon' => 'tasty')
    adapter.read('foo').should == {'bacon' => 'tasty'}
  end
end