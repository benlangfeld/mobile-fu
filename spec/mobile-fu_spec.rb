require_relative "spec_helper"

describe "Changes to ActionController" do

  let(:controller_stubs) { {} }
  let(:controller) { InstanceMethodDummy.new(controller_stubs) }

  describe "set_mobile_format" do

    describe "for an unknown format" do
      let(:controller_stubs) { { request: { format: "php" } } }
      it "should not raise an error" do
        controller.set_mobile_format
      end
      it "should fall back to html" do
        controller.set_mobile_format
        controller.request.format.must_equal :html
      end
    end

    describe "for a known format (that responds to html?)" do
      let(:mock_format) {
        fmt = mock()
        fmt.stubs(:html?).returns(true)
        fmt
      }
      let(:controller_stubs) do
        {
          request: {
            headers: {"X_MOBILE_DEVICE" => "blah" },
            format: mock_format
          }
        }
      end
      it "should not raise an error" do
        controller.set_mobile_format
      end

      it "should maintain the right format" do
        controller.set_mobile_format
        controller.request.format.must_be_same_as :mobile
      end

    end
  end


  describe "is_tablet_device?" do

    let(:user_agent)      { Object.new }
    let(:expected_result) { Object.new }

    it "should return the result from the tablet module" do
      controller.user_agent = user_agent
      ::MobileFu::Tablet.stubs(:is_a_tablet_device?).with(user_agent).returns expected_result
      controller.is_tablet_device?.must_be_same_as expected_result
    end

  end

end

class DummyRequest

  attr_accessor :user_agent
  attr_accessor :format
  attr_accessor :headers

  def initialize(user_agent, format, headers)
    @user_agent = user_agent
    @format = format
    @headers = headers || {}
  end

  def xhr?
    false
  end
end

class InstanceMethodDummy

  include ActionController::MobileFu::InstanceMethods

  attr_accessor :user_agent
  attr_accessor :session

  def initialize(stubs = {})
    @stubs = stubs
    @session = {}
  end

  def request
    request_stubs = @stubs[:request] || {}
    headers = request_stubs[:headers]
    format = request_stubs[:format]
    @request ||= DummyRequest.new(user_agent, format, headers)
  end

  def params
   {action: "show"}.merge(@stubs[:params] || {})
  end

end
