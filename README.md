# 📄 README — Online Auction Platform Database

<p align="center">
  <img src="./small auction logo.png" alt="Logo" width="600">
</p>
<p align="center">
  <em>Created using Canva AI tools. I do not claim ownership of the visual elements.<br>
  If this image presents an issue, please feel free to contact me.</em>
</p>

## 📌 Overview

This project models a **relational database for an online auction platform**, providing functionality to manage users, products, bids, auctions, payments, and delivery statuses. The design ensures traceability, fairness, and security for both buyers and sellers.

---

## 🗂️ Repository Structure

- **`scripts/`**: SQL scripts to create tables, constraints, views, and sample exercises
- **`data/`**: Excel file containing mock data for queries and testing
- **`docs/`**: Documentation files describing the schema and project context
- **`README.md`**: Project overview and setup guide
- **`LICENSE`**: Open-source license information

---

## 🧱 Database Schema Overview

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

---

## 🔄 Functional Requirements

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

---

## 🛠 Notes

- **Data Population**: Use the Excel file in `data/mock data study case 2.xlsx`.
- **Schema & Context**: See `docs/database design schema.pdf` and `docs/exercise context study case 2.pdf`.
- **SQL Setup**: Run the file `scripts/Creating_tables_and_small_exercises.sql` to initialize the schema.

---

## 🔧 Project Scope

This release includes **only core functionality** for managing auctions and transactions in a minimal, structured environment. Future enhancements may include:

- Support for images, reviews, and notifications
- Enhanced security & access roles
- Analytics and audit logging features

---

## 🚀 Getting Started

1. Clone the repo:

   ```bash
   git clone https://github.com/zainea-bogdan/Small_Robust_Auction_Management_System.git
   ```

2. Run the SQL scripts from `scripts/` in Oracle SQL Developer or compatible environment.

3. Load mock data from the `data/` Excel file.

4. Use the views and update queries to test auction logic, winner selection, and transaction tracking.

---

## 📜 License

This project is licensed under the [GPL-3.0 License](./LICENSE).
