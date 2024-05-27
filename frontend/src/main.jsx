import React from "react";
import ReactDOM from "react-dom/client";
import "./index.css";
import { GlobalStateProvider } from "./hooks";
import { createBrowserRouter, RouterProvider, Outlet } from "react-router-dom";
import Header from "./components/header";
import AddMoviePage from "./pages/add_movie";
import HomePage from "./pages/home";

function BaseUI() {
	return (
		<div>
			<Header />
			<Outlet />
		</div>
	);
}
const router = createBrowserRouter([
	{
		path: "/",
		element: <BaseUI />,
		children: [
			{
				index: true,
				element: <HomePage />,
			},
			{
				path: "/add-movie",
				element: <AddMoviePage />,
			},
		],
	},
]);

ReactDOM.createRoot(document.getElementById("root")).render(
	<React.StrictMode>
		<GlobalStateProvider>
			<RouterProvider router={router} />
		</GlobalStateProvider>
	</React.StrictMode>
);
