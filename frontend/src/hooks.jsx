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
		isLogin: false,
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
	const login = async (username, password) =>
		execLogin({ data: { username, password } });

	const isLogin = useMemo(() => {
		return user == null || user.token == null;
	}, [user]);

	// Movies

	const [getMoviesResult, execGetMovies] = useAxios({
		url: "/movies",
		method: "GET",
	});

	const movies = useMemo(() => {
		return getMoviesResult.data || [];
	}, [getMoviesResult.data]);

	const [addMovieResult, execAddMovie] = useAxios(
		{
			url: "/movies",
			method: "POST",
			headers: {
				Authorization: `Bearer ${user.token}`,
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
					isLogin,
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
