# Girl Scout Cookies Smart Contract
### For BUS 498 (Directed Topics in Information Systems - Blockchain) 
#### by Amy Ru (@ameru), Adam Watson (@apwats), and Shusei Yokoi (@Shusei25)

For our class project, we decided to build a smart contract for Girl Scouts to sell their famous Girl Scout Cookies. 

On top of the base trustless sales smart contract, here are the additional features we've implemented:
- An inventory catalog to log unique item descriptors of each cookie box, such as their id tag, name, description, and quantity
- Events which trigger notifications to a Girl Scout or shipment of a box of cookies
- Set the default price of any box of Girl Scout cookies to 0.005 ETH
- Created a cart-like function that keeps track of total number of boxes and price subtotal
- Included time expiry to avoid sending out stale cookies
