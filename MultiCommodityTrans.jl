using JuMP
import DataFrames
import HiGHS
import SQLite
import Tables

println(@__FILE__)
const DBInterface = SQLite.DBInterface;
MAX_EDGE = 625

db = SQLite.DB(joinpath(@__DIR__, "multi.sqlite.db"));
# db

s = SQLite.tables(db);

sources = DBInterface.execute(db, 
    "SELECT location FROM locations WHERE type = \"origin\"") |> 
    Tables.rowtable |>
    x -> map(y -> y.location, x);

sinks = DBInterface.execute(db, 
    "SELECT location FROM locations WHERE type = \"destination\"") |> 
    Tables.rowtable |>
    x -> map(y -> y.location, x);

    products =
    DBInterface.execute(db, "SELECT product FROM products") |>
    Tables.rowtable |>
    x -> map(y -> y.product, x)

model = Model(HiGHS.Optimizer)
set_silent(model)
@variable(model, x[sources, sinks, products] >= 0)

cost = DBInterface.execute(db, "SELECT * FROM cost") |> Tables.rowtable
@objective(
    model,
    Max,
    sum(r.cost * x[r.origin, r.destination, r.product] for r in cost),
);

supply = DBInterface.execute(db, "SELECT * FROM supply") |> Tables.rowtable
for r in supply
    @constraint(model, sum(x[r.origin, :, r.product]) <= r.supply)
end

demand = DBInterface.execute(db, "SELECT * FROM demand")
for r in Tables.rows(demand)
    @constraint(model, sum(x[:, r.destination, r.product]) == r.demand)
end

od_pairs = DBInterface.execute(
    db,
    """
    SELECT a.location as 'origin',
           b.location as 'destination'
    FROM locations a
    INNER JOIN locations b
    ON a.type = 'origin' AND b.type = 'destination'
    """,
)

for r in Tables.rows(od_pairs)
    @constraint(model, sum(x[r.origin, r.destination, :]) <= MAX_EDGE)
end

optimize!(model)
println("    Solution Summary    ")
println(solution_summary(model))
println("    Solution Explicit    ")

begin
    println("         ", join(products, ' '))
    for o in sources, d in sinks
        v = lpad.([round(Int, value(x[o, d, p])) for p in products], 5)
        println(o, " ", d, " ", join(replace.(v, "   0" => "  . "), " "))
    end
end