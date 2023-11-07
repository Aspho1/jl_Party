using Dash

app = dash()

app.layout = html_div() do
    # style = Dict("display" => "flex", "justifyContent" => "center", "alignItems" => "center", "height" => "100vh"),
    
    children = [
        html_div(
            id = "input-grid",
            style = Dict(
                "display" => "grid",
                "gridTemplateColumns" => "repeat(3, 100px)",
                "gridGap" => "10px",
                "justifyContent" => "center"
            ),
            children = [
                html_div([
                    dcc_input(
                        id = "node-1",
                        type = "bool",
                        style = Dict("width" => "100%", "height" => "100px")
                    ),
                    dcc_input(
                        id = "node-2",
                        type = "bool",
                        style = Dict("width" => "100%", "height" => "100px")
                    ),
                    dcc_input(
                        id = "node-3",
                        type = "bool",
                        style = Dict("width" => "100%", "height" => "100px")
                    ),
                    dcc_input(
                        id = "node-4",
                        type = "bool",
                        style = Dict("width" => "100%", "height" => "100px")
                    ),
                    dcc_input(
                        id = "node-5",
                        type = "bool",
                        style = Dict("width" => "100%", "height" => "100px")
                    ),
                    dcc_input(
                        id = "node-6",
                        type = "bool",
                        style = Dict("width" => "100%", "height" => "100px")
                    ),
                    dcc_input(
                        id = "node-7",
                        type = "bool",
                        style = Dict("width" => "100%", "height" => "100px")
                    ),
                    dcc_input(
                        id = "node-8",
                        type = "bool",
                        style = Dict("width" => "100%", "height" => "100px")
                    ),
                    dcc_input(
                        id = "node-9",
                        type = "bool",
                        style = Dict("width" => "100%", "height" => "100px")
                    )
                    
                ]
            ),
                # ... add more cells for other nodes ...
            ]
        ),
        # ... add other components like the solve button ...
    ]

    
    # Create an interactive 3x3 grid for initial state input
    [
        html_h1("Circularly Doubly Linked List Solver"),
        
        # ... add inputs for other nodes ...
        html_button("Solve", id = "solve-button"),
        html_div(id = "solution-output")
    ]
end

# Define a callback to update the solution based on input
callback!(app, Output("solution-output", "children"), 
          Input("solve-button", "n_clicks"), 
          State("node-1", "value"), State("node-2", "value")) do n_clicks, node1, node2
    # ... get values from all nodes ...
    # Run the solver algorithm with the given initial states
    # Format the solution into a displayable format (e.g., a sequence of 3x3 grids)
    return html_div("Solution steps will be displayed here.")
end

run_server(app, "0.0.0.0", 8050)