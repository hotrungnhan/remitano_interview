import React from "react";
import ReactDOM from "react-dom/client";
import "./index.css";
import { GlobalStateProvider } from "./hooks";
import { createBrowserRouter, RouterProvider } from "react-router-dom";
import Header from "./components/header";

const router = createBrowserRouter([
	{
		path: "/",
		children: [
      
    ],
		element: <Header />,
	},
]);

ReactDOM.createRoot(document.getElementById("root")).render(
	<React.StrictMode>
		<GlobalStateProvider>
			<RouterProvider router={router} />
		</GlobalStateProvider>
	</React.StrictMode>
);
