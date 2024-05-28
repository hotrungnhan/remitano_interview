import React from "react";
import ReactDOM from "react-dom/client";
import "./index.css";
import { GlobalStateProvider, useGlobalState } from "./hooks";
import {
	createBrowserRouter,
	RouterProvider,
	Outlet,
	Navigate,
} from "react-router-dom";
import Header from "./components/header";
import AddMoviePage from "./pages/add_movie";
import HomePage from "./pages/home";

import { ToastContainer } from "react-toastify";
import "react-toastify/dist/ReactToastify.css";

function BaseUI() {
	return (
		<div className="flex-col flex w-full h-full">
			<Header />
			<div className="h-full w-full flex flex-col justify-center mt-4">
				<Outlet />
			</div>
		</div>
	);
}

// eslint-disable-next-line react/prop-types
function ProtectedRoute({ redirectPath = "/" }) {
	const { state } = useGlobalState();
	if (!state.isLoggedin) {
		return <Navigate to={redirectPath} replace />;
	}

	return <Outlet />;
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
				element: <ProtectedRoute />,
				children: [
					{
						path: "/add-movie",
						element: <AddMoviePage />,
					},
				],
			},
		],
	},
]);

ReactDOM.createRoot(document.getElementById("root")).render(
	<React.StrictMode>
		<GlobalStateProvider>
			<RouterProvider router={router} />
		</GlobalStateProvider>
		<ToastContainer stacked position="bottom-right" autoClose={2000} newestOnTop pauseOnHover closeOnClick limit={5} />
	</React.StrictMode>
);
