public class BankAccount{
  private var balance:Double
  internal let bank="SBI"
  public init?(balance:Double){
    if balance < 0 {
      return nil
    }
    self.balance= balance
  }

  fileprivate func isValid(_ amount: Double) -> Bool {
    return amount>0
  }

  public func isValid(_ amount: Double){
    if isValid(amount){
      balance += amount
      print("Amount deposit")
    }else{
      print("Invalid amount")
    }
  }
    public func withdraw(_ amount : Double){
      if isValid(amount) && amount<=balance {
        balance -= amount
        print("Amount withdrawn")
      } else{
        print("Insufficient balance")
      }
    }

  public var showBalance:Double{
    return Double
  }
      
