require 'test_helper'

class HasBitmaskAttributes::BitmaskScopeTest < MiniTest::Unit::TestCase

  MockModel = Class.new do
  end

  def model_instance
    @model_instance ||= MockModel.new
  end

  def setup
    @klass = HasBitmaskAttributes::BitmaskScope.make(
      MockModel, 'email_mask',
      send_weekly_email: 0b0001,
      send_monthly_newsletter: 0b0010,
    )
  end

  def subject
    @subject ||= @klass.new(model_instance)
  end

  def test_klass_to_s
    assert_equal "HasBitmaskAttributes::BitmaskScope(HasBitmaskAttributes::BitmaskScopeTest::MockModel#email_mask)", @klass.to_s
  end
end
