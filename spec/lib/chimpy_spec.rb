require 'spec_helper'

describe Spree::Chimpy do

  context "enabled" do
    before do
      #Spree::Chimpy::Interface::List.should_receive(:new).any_number_of_times.with('Members', 'Customers', false).and_return(:list)
      #Spree::Chimpy::Interface::Orders.should_receive(:new).any_number_of_times.and_return(:orders)
      
      #changing the syntax for any_number_of_times to using stub.

      Spree::Chimpy::Interface::List.stub(:new).with('Members', 'Customers', false).and_return(:list)
      Spree::Chimpy::Interface::Orders.stub(:new).and_return(:orders)
      config(key: '1234', list_name: 'Members')
    end

    subject { Spree::Chimpy }

    specify      { should be_configured }
    its(:list)   { should == :list }
    its(:orders) { should == :orders }
  end

  context "disabled" do
    before { config(key: nil) }

    subject { Spree::Chimpy }

    specify      { should_not be_configured }
    its(:list)   { should be_nil }
    its(:orders) { should be_nil }
  end

  context "sync merge vars" do
    let(:interface) { double(:interface) }

    before do
      
      #by the deprecation warning using stub instead of method.

      Spree::Chimpy::Interface::List.stub(:new).with('Members', 'Customers', false).and_return(interface)
      config(key: '1234',
             list_name: 'Members',
             merge_vars: {'EMAIL' => :email, 'FNAME' => :first_name, 'LNAME' => :last_name})
    end

    it "adds var for each" do
      interface.should_receive(:merge_vars).and_return([])
      interface.should_receive(:add_merge_var).with('FNAME', 'First Name')
      interface.should_receive(:add_merge_var).with('LNAME', 'Last Name')

      Spree::Chimpy.sync_merge_vars
    end

    it "skips vars that exist" do
      interface.should_receive(:merge_vars).and_return(%w(EMAIL FNAME))
      interface.should_receive(:add_merge_var).with('LNAME', 'Last Name')

      Spree::Chimpy.sync_merge_vars
    end

    it "doesnt sync if all exist" do
      interface.should_receive(:merge_vars).and_return(%w(EMAIL FNAME LNAME))
      interface.should_not_receive(:add_merge_var)

      Spree::Chimpy.sync_merge_vars
    end
  end

  def config(options = {})
    config = Spree::Chimpy::Configuration.new
    config.key        = options[:key]
    config.list_name  = options[:list_name]
    config.merge_vars = options[:merge_vars]
    config
  end
end
