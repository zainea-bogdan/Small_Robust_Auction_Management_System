# 📄 README — Online Auction Platform Database

## 📌 Overview
This project models a **relational database for an online auction platform**, providing functionality to manage users, products, bids, auctions, payments, and delivery statuses. The design ensures traceability, fairness, and security for both buyers and sellers.

## 🧱 Database Structure

- **`date_personale`**: Stores personal details of users.
- **`cont_utilizator`**: Handles user accounts and roles (buyer/seller).
- **`categorie_produse`**: Product category classification.
- **`produse`**: Auctionable products with validation flags.
- **`licitatii`**: Auctions organized by sellers with payment, delivery, and status tracking.
- **`lista_oferte`**: Records each offer placed by users.
- **`participare_licitatii`**: Tracks user participation in auctions.
- **Views**:
  - `vw_vanzatori`, `vw_cumparatori`: Filtered users by role.
  - `vw_status_licitatii`: Auction status listing.
  - `vw_oferta_castigatoare`: Winning offer per product.
  - `vw_monitorizare_plata`: Tracks payment status.
  - `vw_monitorizare_livrare`: Tracks delivery progress.

## 🔄 Functional Requirements (from project brief)

1. **User Management**
   - Store and validate personal and account data.
   - Differentiate between sellers and buyers.
   - Maintain auction participation history.

2. **Product Management**
   - Register products with starting price and category.
   - Ensure products are verified before auction.
   - Link each product to a seller.

3. **Auction Management**
   - Schedule and manage auction lifecycles.
   - Support multiple statuses: active, completed, inactive, canceled.
   - Handle payment and delivery states.

4. **Offer Management**
   - Record all bids with timestamp and user.
   - Mark the highest offer as the winner.
   - Automatically update offer statuses.

5. **Transaction Handling**
   - Monitor auction winners’ payment completion.
   - Provide live delivery monitoring through views.

## 🛠 Notes

- **Data Population**: Mock data is provided in an Excel file (`auxiliar.xlsx`) in the repository.
- **Constraints & Validations**: Includes checks for date of birth, foreign key references, and status values.
- **Execution Flow**: SQL scripts include creation and teardown of tables and views, along with logic to update auction outcomes.

## 🔧 Project Scope

This version includes **only the basic structural and functional components** required to support core auction operations. Additional features such as user roles, product images, messaging, notifications, or analytics may be integrated in future updates as needed.

## 🚀 Getting Started

1. Run the provided SQL script in Oracle SQL Developer or another PL/SQL-compatible environment.
2. Import mock data using the Excel sheet.
3. Use the provided views and update scripts to simulate auction outcomes.
