require 'active_record/cases/test_base'

class ValidationsTest < ClientSideValidations::ActiveRecordTestBase

  def new_user
    user = Class.new(User)
    def user.name
      'User'
    end
    yield(user)
    user.new
  end

  def test_acceptance_validation_to_client_side_hash
    user = new_user do |p|
      p.validates_acceptance_of :name
    end
    expected_hash = {
      :name => {
        :acceptance => {
          :message => "must be accepted"
        }
      }
    }
    assert_equal expected_hash, user.client_side_validation_hash
  end

  def test_confirmation_validation_to_client_side_hash
    user = new_user do |p|
      p.validates_confirmation_of :name
    end
    expected_hash = {
      :name => {
        :confirmation => {
          :message => "doesn't match confirmation"
        }
      }
    }
    assert_equal expected_hash, user.client_side_validation_hash
  end

  def test_exclusion_validation_to_client_side_hash
    user = new_user do |p|
      p.validates_exclusion_of :name, :in => %w{1}
    end
    expected_hash = {
      :name => {
        :exclusion => {
          :message => "is reserved",
          :in => ["1"]
        }
      }
    }
    assert_equal expected_hash, user.client_side_validation_hash
  end

  def test_format_validation_to_client_side_hash
    user = new_user do |p|
      p.validates_format_of :name, :with => /\.+/
    end
    expected_hash = {
      :name => {
        :format => {
          :message => "is invalid",
          :with => /\.+/
        }
      }
    }
    assert_equal expected_hash, user.client_side_validation_hash
  end

  def test_inclusion_validation_to_client_side_hash
    user = new_user do |p|
      p.validates_inclusion_of :name, :in => %w{1}
    end
    expected_hash = {
      :name => {
        :inclusion => {
          :message => "is not included in the list",
          :in => ["1"]
        }
      }
    }
    assert_equal expected_hash, user.client_side_validation_hash
  end

  def test_length_validation_to_client_side_hash
    user = new_user do |p|
      p.validates_length_of :name, :is => 5
    end
    expected_hash = {
      :name => {
        :length => {
          :messages => {
            :is => "is the wrong length (should be 5 characters)"
          },
          :is => 5
        }
      }
    }
    assert_equal expected_hash, user.client_side_validation_hash
  end

  def test_numericality_validation_to_client_side_hash
    user = new_user do |p|
      p.validates_numericality_of :name
    end
    expected_hash = {
      :name => {
        :numericality => {
          :messages => {
            :numericality => "is not a number"
          }
        }
      }
    }
    assert_equal expected_hash, user.client_side_validation_hash
  end

  def test_presence_validation_to_client_side_hash
    user = new_user do |p|
      p.validates_presence_of :name
    end
    expected_hash = {
      :name => {
        :presence => {
          :message => "can't be blank"
        }
      }
    }
    assert_equal expected_hash, user.client_side_validation_hash
  end

  def test_uniqueness_validation_to_client_side_hash
    user = new_user do |p|
      p.validates_uniqueness_of :name
    end
    expected_hash = {
      :name => {
        :uniqueness => {
          :message => "has already been taken",
          :case_sensitive => nil
        }
      }
    }
    assert_equal expected_hash, user.client_side_validation_hash
  end
end
