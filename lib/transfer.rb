require 'pry'

class Transfer
  attr_accessor :status
  attr_reader :sender, :receiver, :amount

  def initialize(sender, receiver, amount)
    @status = "pending"
    @sender = sender
    @receiver = receiver
    @amount = amount
  end

  def valid?
    valid = []
    if self.sender.valid? == true && self.receiver.valid? == true
      valid = true
    else
      valid = false
    end
    return valid
  end

  def execute_transaction
    return_value = []
    if self.status != "complete" && self.valid? == true && self.sender.balance >= @amount
      self.sender.deposit(-@amount)
      self.receiver.deposit(@amount)
      @status = "complete"
    else
      return_value = "Transaction rejected. Please check your account balance."
      @status = "rejected"
    end
    return return_value
  end

  def reverse_transfer
    if @status == "complete"
      self.sender.deposit(@amount)
      self.receiver.deposit(-@amount)
      @status = "reversed"
    end
  end

end

#binding.pry

