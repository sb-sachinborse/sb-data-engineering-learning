class DataTransformer:

    def transform(self, customers, orders, payments):

        # ----------------------------
        # Clean Customers
        # ----------------------------
        customers["full_name"].fillna("UNKNOWN", inplace=True)
        customers["city"].fillna("UNKNOWN", inplace=True)

        # ----------------------------
        # Clean Orders
        # ----------------------------
        orders = orders[orders["order_status"] == "completed"]
        orders["order_amount"].fillna(0, inplace=True)

        # Remove invalid customer references
        orders = orders[orders["customer_id"].isin(customers["customer_id"])]

        # ----------------------------
        # Aggregate Orders
        # ----------------------------
        order_summary = (
            orders.groupby("customer_id")
            .agg(
                total_orders=("order_id", "count"),
                total_revenue=("order_amount", "sum")
            )
            .reset_index()
        )

        # ----------------------------
        # Final Join (Analyst-Ready)
        # ----------------------------
        final_df = order_summary.merge(
            customers,
            on="customer_id",
            how="left"
        )

        return final_df[[
            "customer_id",
            "full_name",
            "city",
            "total_orders",
            "total_revenue"
        ]]
