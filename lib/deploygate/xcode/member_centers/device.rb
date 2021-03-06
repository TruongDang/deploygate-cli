module DeployGate
  module Xcode
    module MemberCenters
      class Device
        attr_reader :udid, :user_name ,:device_name, :member_center
        attr_accessor :register_name

        # @param [String] udid
        # @param [String] user_name
        # @param [String] device_name
        # @return [DeployGate::Devices::Ios]
        def initialize(udid, user_name, device_name)
          @udid = udid
          @user_name = user_name
          @device_name = device_name

          @register_name = generate_register_name(@user_name, @device_name)
        end

        def registered?
          instance = DeployGate::Xcode::MemberCenter.instance
          !instance.launcher.device.find_by_udid(@udid).nil?
        end

        # @return [void]
        def register!
          instance = DeployGate::Xcode::MemberCenter.instance
          return if registered?

          instance.launcher.device.create!(name: @register_name, udid: @udid)
        end

        # @return [String]
        def to_s
          "Name: #{self.register_name}, UDID: #{self.udid}"
        end

        private

        def generate_register_name(user_name, device_name)
          name = ''
          name += "#{user_name} - " if !user_name.nil? && user_name != ''
          name += device_name

          name
        end
      end
    end
  end
end
