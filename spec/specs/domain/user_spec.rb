require "spec_helper"

describe User do
  let(:sut) { User.new }

  describe "when matching a password" do
    let!(:result) { sut.change_password('password') }

    describe "when the password does not match" do
      it "should return false" do
        sut.password_matches('blah').should be_false
      end
    end

    describe "when the password matches" do
      it "should return true" do
        sut.password_matches('password').should be_true
      end
    end
  end
end
