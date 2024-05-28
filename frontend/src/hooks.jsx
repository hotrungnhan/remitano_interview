import React, { useMemo } from "react";
import PropTypes from "prop-types";
import axios from "axios";
import { makeUseAxios } from "axios-hooks";
import { useEffect } from "react";
import Swal from "sweetalert2";
import withReactContent from "sweetalert2-react-content";
import { createConsumer } from "@rails/actioncable";
import { toast } from "react-toastify";

const MySwal = withReactContent(Swal);

export const GlobalContext = React.createContext({
	action: {
		notification: MySwal,
		login: {
			exec: () => {},
			error: null,
			loading: true,
		},
		logout: {
			exec: () => {},
		},
		getMovies: {
			exec: () => {},
			error: null,
			loading: true,
		},
		addMovie: {
			exec: () => {},
			error: null,
			loading: true,
		},
	},
	state: {
		isLoggedin: false,
		user: {
			email: null,
			token: null,
		},
		movies: [],
	},
});

const useGlobalState = () => {
	const context = React.useContext(GlobalContext);

	return context;
};

const WS_ENDPOINT = "ws://localhost:3000";
const API_ENDPOINT = "http://localhost:3000";

const useAxios = makeUseAxios({
	axios: axios.create({ baseURL: API_ENDPOINT }),
});

const GlobalStateProvider = ({ children }) => {
	// Auth
	const [user, setUser] = React.useState({
		email: null,
		token: null,
	});

	// ACTION CABLE
	const actionCable = useMemo(() => {
		return user
			? createConsumer(`${WS_ENDPOINT}/cable?token=${user?.token}`)
			: null;
	}, [user]);

	useEffect(() => {
		if (actionCable) {
			const subscription = actionCable.subscriptions.create(
				{
					channel: "NotificationChannel",
				},
				{
					connected: () => {
						console.log("Connected to NotificationChannel");
					},
					received: (video) => {
						toast(video, {});
					},
				}
			);

			return () => {
				subscription.unsubscribe();
			};
		}
	}, [actionCable]);

	// eslint-disable-next-line no-unused-vars
	const [loginResult, execLogin, resetLogin] = useAxios(
		{
			url: "/login",
			method: "POST",
		},
		{ manual: true, useCache: false }
	);

	useEffect(() => {
		if (loginResult.data != null) {
			setUser(loginResult.data);
		}
	}, [loginResult.data]);

	const logout = () => {
		setUser(null);
	};
	// eslint-disable-next-line no-unused-vars
	const login = async (username, password) => {
		// execLogin({ data: { username, password } });
		// toast("login", {
		// 	position: "bottom-right",
		// });
		setUser({ email: "Ho Trung Nhan", token: "123" });
	};

	const isLoggedin = useMemo(() => {
		console.log(user != null && user?.token != null);
		return user != null && user?.token != null;
	}, [user]);

	// Movies

	const [getMoviesResult, execGetMovies] = useAxios({
		url: "/movies",
		method: "GET",
	});

	const movies = useMemo(() => {
		return (
			getMoviesResult.data || [
				{
					id: "123456",
					title: "Title from Do Mixi",
					description: "Description from Do Mixi",
					uploader: {
						email: "hotrungnhan@gmail.com",
					},
					metadata: {
						upvote: 100,
						downvote: 1000,
					},
					youtubeUrl: "https://www.youtube.com/embed/szHyNw9KzzE",
					youtubeId: "szHyNw9KzzE",
					createdAt: "2021-09-21T14:00:00Z",
					"auth-metadata": {
						vote: "like",
					},
				},
				{
					id: "123456",
					title: "Title from Do Mixi",
					description: "Description from Do Mixi",
					uploader: {
						email: "hotrungnhan@gmail.com",
					},
					metadata: {
						upvote: 100,
						downvote: 1000,
					},
					youtubeUrl: "https://www.youtube.com/embed/9b_rRNOrgSo",
					youtubeId: "9b_rRNOrgSo",
					createdAt: "2021-09-21T14:00:00Z",
					"auth-metadata": {
						vote: "like",
					},
				},
				{
					id: "123456",
					title: "Title from Do Mixi",
					description: "Description from Do Mixi",
					uploader: {
						email: "hotrungnhan@gmail.com",
					},
					metadata: {
						upvote: 100,
						downvote: 1000,
					},
					youtubeUrl: "https://www.youtube.com/embed/9b_rRNOrgSo",
					youtubeId: "9b_rRNOrgSo",
					createdAt: "2021-09-21T14:00:00Z",
					"auth-metadata": {
						vote: "like",
					},
				},
			]
		);
	}, [getMoviesResult.data]);

	const [addMovieResult, execAddMovie] = useAxios(
		{
			url: "/movies",
			method: "POST",
			headers: {
				Authorization: `Bearer ${user?.token}`,
			},
		},
		{ manual: true, useCache: false }
	);

	const addMovie = async (youtubeUrl) => {
		await execAddMovie({ data: { youtubeUrl } });
	};

	return (
		<GlobalContext.Provider
			value={{
				action: {
					notification: MySwal,
					login: {
						exec: login,
						error: loginResult.error,
						loading: loginResult.loading,
					},
					logout: {
						exec: logout,
					},
					getMovie: {
						exec: execGetMovies,
						error: getMoviesResult.error,
						loading: getMoviesResult.loading,
					},
					addMovie: {
						exec: addMovie,
						error: addMovieResult.error,
						loading: addMovieResult.loading,
					},
				},
				state: {
					isLoggedin,
					user,
					movies,
				},
			}}
		>
			{children}
		</GlobalContext.Provider>
	);
};

GlobalStateProvider.propTypes = {
	children: PropTypes.node.isRequired,
};
export { useGlobalState, GlobalStateProvider };
