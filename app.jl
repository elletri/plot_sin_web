using Pkg
using Oxygen
using JSON

# Debugging: confirm Julia version and project
println(">>> Julia version: ", VERSION)
println(">>> Active Project:")
Pkg.status()

# Serve static frontend
@get "/" function(req)
    try
        file("index.html")
    catch e
        println("Error serving index.html: ", e)
        return json(Dict("error" => "index.html not found"))
    end
end

# Endpoint for sine plot data
@get "/plot" function(req)
    try
        qp = queryparams(req)
        A = parse(Float64, qp["A"])
        f = parse(Float64, qp["f"])
        x = collect(range(0, 1, length=500))
        y = A .* sin.(2π .* f .* x)
        return json(Dict("x" => x, "y" => y))
    catch e
        println("Error generating plot: ", e)
        return JSON.json(Dict("error" => "failed to generate plot"))
    end
end

# Bind to Render port
port = parse(Int, get(ENV, "PORT", "10000"))
println(">>> Starting Oxygen server on 0.0.0.0:$port ...")

serve(host="0.0.0.0", port=port)