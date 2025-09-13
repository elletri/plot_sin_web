# Use official Julia image
FROM julia:1.11-bullseye

# Set working directory inside container
WORKDIR /app

# Copy dependency files first for caching
COPY Project.toml Manifest.toml* ./

# Install Julia dependencies
RUN julia -e 'using Pkg; Pkg.activate("."); Pkg.instantiate(); Pkg.precompile()'

# Copy the rest of the app
COPY . .

# Expose Render default port
EXPOSE 10000

# Run app.jl with the project environment
ENTRYPOINT ["julia", "--project=.", "app.jl"]