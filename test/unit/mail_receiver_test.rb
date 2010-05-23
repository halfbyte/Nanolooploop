require 'test_helper'

class MailReceiverTest < ActionMailer::TestCase

  context "receiving a valid mail to private drop" do
    setup do
      Loop.destroy_all
      User.destroy_all
      @user = Factory(:user, :mail_drop_private => "u051i9j0", :mail_drop_public => "u194920d")
      User.stubs(:where).with({:id => "12616276ae62718f912b9c0e"}).returns([@user])

    end
    
    should "should create loop" do
      assert_difference "Loop.count" do
        MailReceiver.receive(mail_fixture("nanoloop"))
      end
    end

    should "should create loop even if P is lowercase" do
      assert_difference "Loop.count" do
        MailReceiver.receive(mail_fixture("nanoloop_with_lowercase_private_maildrop"))
      end
      loopie = Loop.where(:message_id => "<9230773D-FA1B-40B2-AD3A-A3F58E6D2423@headflash.com>").first
      assert_equal @user, loopie.user
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
