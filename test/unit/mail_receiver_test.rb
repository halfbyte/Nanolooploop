require 'test_helper'

class MailReceiverTest < ActionMailer::TestCase

  context "receiving a valid mail to private drop" do
    setup do
      @user = Factory(:user, :mail_drop_private => "u051i9j0", :mail_drop_public => "u194920d")
      User.stubs(:find_by_id).returns(@user)
    end
    should "should create loop" do
      assert_difference "Loop.count" do
        MailReceiver.receive(mail_fixture("nanoloop"))
      end
    end

    should "assign the loop to the right user" do
      loopie = MailReceiver.receive(mail_fixture("nanoloop"))
      @user.reload.loops.include?(loopie)
    end

    should "save message_id to allow for better cueing" do
      loop = MailReceiver.receive(mail_fixture("nanoloop"))
      assert_not_nil loop.message_id, "message_id should not be empty"
    end

    should "save loop, even if no user has been found in the database" do
      assert_difference "Loop.count" do
        MailReceiver.receive(mail_fixture("nanoloop_with_wrong_mail"))
      end
    end

  end

end
