using Oxygen

@get "/" function(req)
    file("index.html")
end

@get "/plot" function(req)
    qp = queryparams(req)
    A = parse(Float64, qp["A"])
    f = parse(Float64, qp["f"])
    x = collect(range(0, 1, length=500))
    y = A .* sin.(2π .* f .* x)
    return json(Dict("x" => x, "y" => y))
end

# Render sets the port in ENV["PORT"]
port = parse(Int, get(ENV, "PORT", "10000"))
serve(host="0.0.0.0", port=port)

