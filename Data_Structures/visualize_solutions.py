import dash
from dash import html, dcc
from dash.dependencies import Input, Output, State

# Create a Dash application
app = dash.Dash(__name__)


def make_Initial():
    c = []
    for i in range(1,10):
        if i == 5:
            c.append(html.Div(
            dcc.Input(
                id=f'node-{i}',
                type='text',  # Placeholder, replace with a suitable component for boolean input
                min = 0,
                max = 0,
                style={'width': '100%', 'height': '100%', 'background-color':'#302f2f','border':'0'}
            ),
            style={'width': '100px', 'height': '100px', 'display': 'flex', 'alignItems': 'center', 'justifyContent': 'center','background-color':'black', 'border':'0'}
        ))
        else:
            c.append(html.Div(
            dcc.Input(
                id=f'node-{i}',
                type='text',  # Placeholder, replace with a suitable component for boolean input
                min = 0,
                max = 1,
                style={'width': '100%', 'height': '100%'}
            ),
            style={'width': '100px', 'height': '100px', 'display': 'flex', 'alignItems': 'center', 'justifyContent': 'center'}
        ))
    return c



# Define the app layout
app.layout = html.Div(
    style={'display': 'flex', 'justifyContent': 'center', 'alignItems': 'center', 'height': '100vh','background-color':'#302f2f'},
    children=[
        html.Div(
            id='input-grid',
            style={
                'display': 'grid',
                'gridTemplateColumns': 'repeat(3, 100px)',
                'gridGap': '10px',
                'justifyContent': 'center'
            },
            children=make_Initial()
        ),
        # Add additional components such as buttons below your grid if necessary
    ]
)

# Define callbacks for interactivity if needed
@app.callback(
    Output('output-container', 'children'),
    [Input(f'node-{i}', 'value') for i in range(1, 10)]
)
def update_output(*values):
    # Logic to handle the activation and state updates goes here
    pass

# Run the server
if __name__ == '__main__':
    app.run_server(debug=True)
