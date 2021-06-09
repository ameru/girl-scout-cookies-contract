# 🍪 Girl Scout Cookies Smart Contract 🍪
#### For BUS 498 (Directed Topics in Information Systems - Blockchain) by Amy Ru (@ameru), Adam Watson (@apwats), and Shusei Yokoi (@Shusei25)

For our class project, we decided to build a smart contract for Girl Scouts to sell their famous Girl Scout Cookies. 

## Project Features
On top of the base trustless sales smart contract, here are the additional features we've implemented:
- An inventory catalog to log unique item descriptors of each cookie box, such as their id tag, name, description, and quantity
- Events which trigger notifications to a Girl Scout or shipment of a box of cookies
- Set the default price of any box of Girl Scout cookies to 0.005 ETH
- Created a cart-like function that keeps track of total number of boxes and price subtotal
- Included time expiry to avoid sending out stale cookies

## Deploying the Contract
This is the start screen containing your wallet and contract fields:

![Start](https://user-images.githubusercontent.com/44534814/121441689-1f4a0780-c93f-11eb-94e6-16dbe413e202.png)

Here are the results after the contract is created. This will cost you some ETH.

![ResultsafterContractCreationShowingDecreaseinETH](https://user-images.githubusercontent.com/44534814/121442530-b6638f00-c940-11eb-8873-2d084fca61a5.PNG)

This is the createCart object where you can create your Cart view:

![CreateCartandContractView](https://user-images.githubusercontent.com/44534814/121442223-0726b800-c940-11eb-9b19-979fbc1d6188.PNG)

Here is the status of the contract after you create your cart:

![ResultsAfterCartCreation](https://user-images.githubusercontent.com/44534814/121442280-24f41d00-c940-11eb-97ee-5576a67b4f51.PNG)

This is the status of the contract when you confirm your purchase:

![ConfirmPurchaseDemo](https://user-images.githubusercontent.com/44534814/121442308-3806ed00-c940-11eb-8cec-ea6ffcfa2e17.PNG)

Perks of being the middleman, and the plight of being a girl scout - it seems as if the full value of the purchase wasn't issued to the cookie seller.

![aftertheTransactionbutwechargedtoolittlesotheylostmoney](https://user-images.githubusercontent.com/44534814/121442339-4fde7100-c940-11eb-93a1-765b7f9e3325.PNG)

Contract status after confirmation is received:

![after_confirmReceived_State3Locked](https://user-images.githubusercontent.com/44534814/121442440-8d42fe80-c940-11eb-94d6-e781c0902b20.PNG)

## Test Cases for Errors
This is the error you will get when you try to access privileged activity without privileged access:

![ErrorForPrivelegedActivity(confirmReceived)](https://user-images.githubusercontent.com/44534814/121441727-325cd780-c93f-11eb-9a81-9300c0a24292.PNG)

This is the error you will get when the input for buyer and seller are the same:

![BuyerCannotBeSellerERROR](https://user-images.githubusercontent.com/44534814/121441732-34269b00-c93f-11eb-9a2c-7b36d8973e7c.PNG)

This is the error you will get if you try to buy stale cookies:

![StaleCookieERROR](https://user-images.githubusercontent.com/44534814/121441713-2bce6000-c93f-11eb-99cd-38d568a0ed58.PNG)
