require 'test_helper'

class HasBitmaskAttributes::BitmaskScopeTest < MiniTest::Unit::TestCase

  MockModel = Class.new do
  end

  def model_instance
    @model_instance ||= MockModel.new
  end

  def setup
    @klass = HasBitmaskAttributes::BitmaskScope.make(
      MockModel, 'email_mask', 'emails',
      send_weekly_email:        0b0001,
      send_monthly_newsletter:  0b0010,
      send_daily_spam:          0b0100,
    )
  end

  def subject
    @subject ||= @klass.new
  end

  def test_klass_to_s
    assert_equal "HasBitmaskAttributes::BitmaskScope(HasBitmaskAttributes::BitmaskScopeTest::MockModel#email_mask)", @klass.to_s
  end


  def test_with_attribute
    MockModel.expects(:where).with("email_mask = email_mask & 1")
    subject.with_emails(:send_weekly_email)
  end

  def test_with_attributes
    MockModel.expects(:where).with("email_mask = email_mask & 6")
    subject.with_emails([:send_monthly_newsletter, :send_daily_spam])
  end
end