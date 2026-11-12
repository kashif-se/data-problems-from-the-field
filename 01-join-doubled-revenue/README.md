# 01. The join that doubled revenue

A small online coffee shop has a sales dashboard built on dbt and DuckDB. The pipeline is green: every model builds and every test passes.

The dashboard says October revenue was up 13.6% on September:

| Month | Orders | Revenue |
|---|---|---|
| Sep 2026 | 1,635 | $35,943.00 |
| Oct 2026 | 1,794 | $40,831.00 |

Sales is happy. Finance is not. Their payment report shows the shop collected **$30,303.50** for September orders and **$30,707.00** for October orders, so revenue was roughly flat.

Nothing in the pipeline has failed. Your job is to find out which number is right, why the other one is wrong, and make sure it can't happen again without a test going red.

## Setup

You need Python 3.10 or newer.

```bash
cd 01-join-doubled-revenue
python -m venv .venv
source .venv/bin/activate        # Windows: .venv\Scripts\activate
pip install -r requirements.txt

dbt build
dbt show -s monthly_revenue
```

`dbt build` loads the CSVs in `seeds/` into a local DuckDB file, builds the models and runs the tests. Everything should pass. That's the point.

To poke around with SQL:

```bash
dbt show --inline "select * from {{ ref('fct_orders') }} limit 20"
```

## The data

| Table | One row per |
|---|---|
| `raw_orders` | order (`order_total` is what the customer was charged) |
| `raw_order_items` | line on an order |
| `raw_products` | product, with its category |
| `raw_payments` | successful payment (cancelled orders have none) |

The models:

```
seeds/raw_*  ->  models/staging/stg_*  ->  models/marts/fct_orders  ->  models/marts/monthly_revenue
```

## Your task

1. Work out why the dashboard number and the finance number don't match. Write down the cause in a sentence or two.
2. Fix the models so `monthly_revenue` matches what was actually collected.
3. Keep the dashboard's category filter working. Sales still wants to see revenue by product category.
4. Add tests that would have caught this.

## Done when

- [ ] `dbt build` passes.
- [ ] `monthly_revenue` shows $30,303.50 for September and $30,707.00 for October.
- [ ] `fct_orders` has exactly one row per completed order, and a `unique` test on `order_id` proves it.
- [ ] Revenue by category still works, and the categories add up to the monthly total.
- [ ] There is a test that compares revenue against `raw_payments` and fails if they drift apart.
- [ ] You can explain the bug to someone non-technical in two sentences.

## Hints

Try these one at a time, only if you're stuck.

<details>
<summary>Hint 1</summary>

Count the rows in `stg_orders` with status `completed`, then count the rows in `fct_orders`. Should they be the same?
</details>

<details>
<summary>Hint 2</summary>

Find an `order_id` that appears more than once in `fct_orders` and look at all of its rows. What's different between them, and what's the same?
</details>

<details>
<summary>Hint 3</summary>

Look up "grain" in data modelling. What is the grain of `fct_orders` supposed to be, and what is it actually after the joins? When an order has three products, which column gets copied three times?
</details>

<details>
<summary>Hint 4</summary>

An order can contain products from several categories, so "the category of an order" isn't one value. Revenue by category belongs at a different grain from revenue by order. Which table already has that grain?
</details>

<details>
<summary>Hint 5</summary>

When you compare against payments, match them to orders by `order_id` and group by the order's month, not the payment's month. At least one order placed late on 30 September was paid on 1 October.
</details>

## Going further

- Why did October look *better* rather than just bigger? Look at how many items per order each month had. (October ran an add-on promotion.)
- Write a generic dbt test that checks a model has one row per key, and reuse it.
- Look at `dbt_utils.equal_rowcount` and `dbt_expectations` and decide whether you'd use them here.

## Solution

There's a worked solution on the [`solutions`](https://github.com/kashif-se/data-problems-from-the-field/tree/solutions/01-join-doubled-revenue) branch. Try it yourself first.
