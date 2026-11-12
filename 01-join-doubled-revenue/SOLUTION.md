# Solution: the join that doubled revenue

## What was wrong

`fct_orders` was supposed to have one row per order. To let the dashboard filter by category, someone joined `order_items` and `products` into it. After that join it had one row per order *line*, but it still carried the order's full `order_total` on every row. An order with three items was counted three times.

In plain words: we added up each receipt once for every item on it.

October looked better than September because it ran an add-on promotion. More orders had extra items, so more orders were counted more than once. Real revenue was up 1.3%, not 13.6%.

None of the existing tests caught it because none of them checked the grain. `not_null` on `order_id` passes whether there is one row per order or five.

## The fix

- `fct_orders` is back to one row per completed order. No item joins.
- New `fct_order_items` at one row per order line, with the category.
- New `revenue_by_category`, which sums `line_total` from `fct_order_items`.
- `monthly_revenue` is unchanged. It was fine; its input was wrong.

## The tests that would have caught it

- `unique` on `fct_orders.order_id`. This alone fails on the original code (454 duplicate order ids).
- `assert_revenue_matches_payments`: monthly revenue must equal what `raw_payments` says was collected for that month's orders.
- `assert_categories_add_up`: category revenue must add up to the monthly total.

The first is the cheap, general one: every model should state its grain, and have a uniqueness test on the key that defines it. The second is the one finance would have written. A reconciliation against an independent source catches problems you didn't think to test for.

## Results

| Month | Before | After | Collected |
|---|---|---|---|
| Sep 2026 | $35,943.00 | $30,303.50 | $30,303.50 |
| Oct 2026 | $40,831.00 | $30,707.00 | $30,707.00 |
