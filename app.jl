using Oxygen

# Serve your frontend
@get "/" function(req)
    file("index.html")
end

# Endpoint for sine plot data
@get "/plot" function(req)
    qp = queryparams(req)
    A = parse(Float64, qp["A"])
    f = parse(Float64, qp["f"])
    x = collect(range(0, 1, length=500))
    y = A .* sin.(2π .* f .* x)
    return json(Dict("x" => x, "y" => y))
end

# Bind to Render’s PORT or default 10000
port = parse(Int, get(ENV, "PORT", "10000"))
println("Starting Oxygen server on 0.0.0.0:$port ...")
serve(host="0.0.0.0", port=port)