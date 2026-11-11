let account =BankAccount(balance: 5000)

if let account=account{
  print("Bank", account.bank)
  print("Balance:",account.showBalance)
  account.deposit(1000)
  account.withdraw(500)
  account.withdraw(10000)
  account.deposit(-200)

  print("Final balance:" account.showBalance)
}else{
  print("Account not created")
}
let account2=BankAccount(balance:-500)
if account2 == nil{
  print("Invalid account balance")
}
