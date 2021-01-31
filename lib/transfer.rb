class Transfer
  attr_accessor :sender, :receiver, :amount, :status

  @@all = []

  def initialize(sender, receiver, amount)
    @sender = sender
    @receiver = receiver
    @amount = amount
    @status = "pending"
  end

  def all
    @@all
  end

  def valid?
    @@all << self
    sender.balance > amount && sender.valid? && receiver.valid? && self.all.count(self) < 2
  end

  def execute_transaction
    if self.valid?
      sender.balance -= amount
      receiver.balance += amount
      self.status = "complete"
    else
      self.status = "rejected"
      "Transaction rejected. Please check your account balance."
    end
  end

  def reverse_transfer
    sender = @@all.last.sender
    receiver = @@all.last.receiver
    sender.balance += amount
    receiver.balance -= amount
    self.status = "reversed"
  end

end
