require 'test_helper'

class ChefTest < ActiveSupport::TestCase
    
    def setup
        @chef = Chef.new(chefname: "john", email: "john@example.com")
    end
    
    test "chef should be valid" do
        assert @chef.valid?
    end
    
    test "chefname should be present" do
        @chef.chefname = " "
        assert_not @chef.valid? 
    end
    
    test "chefname not too long" do
        @chef.chefname = "a" * 41
        assert_not @chef.valid? 
    end

    test "chefname not too short" do
        @chef.chefname = "aa"
        assert_not @chef.valid? 
    end

    test "email should be present" do
        @chef.email = " "
        assert_not @chef.valid? 
    end
    
    test "email should be in limits" do
        @chef.email = "a" * 101 + "@example.com"
        assert_not @chef.valid? 
    end

    test "email unique" do
        dup_chef = @chef.dup
        dup_chef.email = @chef.email.upcase
        @chef.save
        assert_not dup_chef.valid?
    end
    
    test "email should be valid" do
        valid_addresses = %w[user@eee.com R_TDD_DS@eee.hello.org]
        valid_addresses.each do |va|
            @chef.email = va
            assert @chef.valid?, '#{va.inspect} should be valid'
        end
    end
    
    test "email no acepta emails invalidos" do
       invalid_addresses = %w[user@example,com user_at_eee.org] 
       invalid_addresses.each do |ia|
            @chef.email = ia
            assert_not @chef.valid?, '#{ia.inspect} should not be valid'
        end       
    end
    
end