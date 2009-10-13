# happily swiped from http://return42.blogspot.com/2009/09/testing-rails-obsevers-with-shoulda.html
class Test::Unit::TestCase
  def self.should_be_an_observer
    symbol = self.name.gsub(/Test$/, '').underscore.to_sym
  
    should "be registered as an observer" do
      assert ActiveRecord::Base.observers.include?(symbol)
    end
  end
  
  def self.should_observe(*models)
    klass = self.name.gsub(/Test$/, '').constantize
    obj = klass.send(:new)
    models.flatten!
    models.collect! { |model| model.is_a?(Symbol) ? model.to_s.camelize.constantize : model }

    models.each do |model|
      should "observe #{model.name}" do
        assert obj.observed_classes.include?(model)
      end
    end
  end
end