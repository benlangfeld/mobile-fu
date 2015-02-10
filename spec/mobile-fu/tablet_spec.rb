require_relative '../spec_helper.rb'

describe MobileFu::Tablet do

  describe "is a tablet device?" do

    ['Ipad', 
     'ipad', 
     'IPAD',
     'Mozilla/5.0 (compatible; MSIE 10.0; Windows NT 6.2; ARM; Trident/6.0; Touch)',     
     'Mozilla/5.0 (Linux; Android 4.4; SM-T700 Build/KOT49H)'
    ].each do |user_agent|

      describe "examples that are a tablet" do

        it "should return true for #{user_agent}" do

          MobileFu::Tablet.is_a_tablet_device?(user_agent).must_equal true

        end

      end

    end

    ['iPhone', nil, 'MSIE'].each do |user_agent|

      describe "examples that are a tablet" do

        it "should return false for #{user_agent}" do

          MobileFu::Tablet.is_a_tablet_device?(user_agent).must_equal false

        end

      end

    end

  end

end
