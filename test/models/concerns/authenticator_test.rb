require 'test_helper'

class AuthenticatorTest < ActiveSupport::TestCase
  setup do
    @pseudo_class = Struct.new(:authenticator) { include Authenticator }
  end

  test 'team_member? should return true if team member' do
    @pseudo_class.stub(:fetch_member_uids, %w(U11111111 U22222222)) do
      assert @pseudo_class.team_member?('U11111111')
    end
  end

  test 'team_member? should return false if not team member' do
    @pseudo_class.stub(:fetch_member_uids, %w(U11111111 U22222222)) do
      refute @pseudo_class.team_member?('U33333333')
    end
  end

  test 'fetch_member_uids should return uids for undeleted members of team' do
    VCR.use_cassette 'slack/users_info' do
      assert_equal %w(U42424242 U66666666), @pseudo_class.fetch_member_uids
    end
  end
end
