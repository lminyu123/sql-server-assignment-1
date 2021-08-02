using System;

namespace Exercise7
{
    class Program
    {
        static void Main(string[] args)


        {
            int pin, choice;
            int deposit, withdraw, updatemoney, money = 1000;
            Console.WriteLine("Enter you Pin Number");
            pin = Convert.ToInt32(Console.ReadLine());


            Console.WriteLine("********Welcome to ATM Service**************");
            Console.WriteLine("1. Check Balance");
            Console.WriteLine("2. Withdraw Cash");
            Console.WriteLine("3. Deposit Cash");
            Console.WriteLine("4. Quit");


            Console.WriteLine("*********************************************");
            Console.WriteLine("Enter your Choice:");
            choice = int.Parse(Console.ReadLine());
            switch (choice)
            {
                case 1:
                    Console.WriteLine("\n YOUR BALANCE IN Rs : {0} ", money);
                    break;
                case 2:
                    Console.WriteLine("\n Enter the withdraw money:");
                    withdraw = int.Parse(Console.ReadLine());
                    if (withdraw > (money))
                    {
                        Console.WriteLine("INSUFFICENT BALANCE");
                    }
                    else
                        {
                        updatemoney = money - withdraw;
                        Console.WriteLine("\n\n PLEASE COLLECT CASH");
                        Console.WriteLine("\n YOUR CURRENT BALANCE IS {0}", updatemoney);
                        }

                    break;
                case 3:
                    Console.WriteLine("\n ENTER THE AMOUNT TO DEPOSIT");
                    deposit = int.Parse(Console.ReadLine());
                    updatemoney = money + deposit;
                    Console.WriteLine("YOUR BALANCE IS {0}", updatemoney);
                    break;
                case 4:
                    Console.WriteLine("\n THANK U USING ATM");
                    break;
            }
        }
        
    }
}
    
