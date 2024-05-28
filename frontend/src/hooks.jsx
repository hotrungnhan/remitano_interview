import React, { useMemo } from "react";
import PropTypes from "prop-types";
import axios from "axios";
import { makeUseAxios } from "axios-hooks";
import { useEffect } from "react";

export const GlobalContext = React.createContext({
	action: {
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

const useAxios = makeUseAxios({
	axios: axios.create({ baseURL: "https://localhost:3000" }),
});

const GlobalStateProvider = ({ children }) => {
	// Auth
	const [user, setUser] = React.useState({
		email: null,
		token: null,
	});

	// eslint-disable-next-line no-unused-vars
	const [loginResult, execLogin] = useAxios(
		{
			url: "/login",
			method: "POST",
		},
		{ manual: true }
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
					title: "Hello from Do Mixi",
					description: "Hello from Do Mixi",
					uploader: {
						email: "hotrungnhan@gmail.com",
					},
					metadata: {
						upvote: 100,
						downvote: 1000,
					},
					youtubeUrl: "https://www.youtube.com/watch?v=3QlZvOJ8fjg",
					youtubeId: "3QlZvOJ8fjg",
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
		{ manual: true }
	);

	const addMovie = async (youtubeUrl) => {
		await execAddMovie({ data: { youtubeUrl } });
	};

	return (
		<GlobalContext.Provider
			value={{
				action: {
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
