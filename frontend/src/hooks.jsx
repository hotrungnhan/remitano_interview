import React, { useMemo } from "react";
import PropTypes from "prop-types";
import axios from "axios";
import { makeUseAxios } from "axios-hooks";
import { useEffect } from "react";
import Swal from "sweetalert2";
import withReactContent from "sweetalert2-react-content";
import { createConsumer } from "@rails/actioncable";

import { useCallback } from "react";
import { toast } from "react-toastify";

const MySwal = withReactContent(Swal);

export const GlobalContext = React.createContext({
	action: {
		notification: MySwal,
		login: {
			exec: () => Promise.resolve(),
		},

		register: {
			exec: () => Promise.resolve(),
		},
		logout: {
			exec: () => {},
		},
		getMovies: {
			exec: () => Promise.resolve(),
			error: null,
			loading: true,
			reset: () => {},
		},
		addMovie: {
			exec: () => Promise.resolve(),
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

export const useGlobalState = () => {
	const context = React.useContext(GlobalContext);

	return context;
};

const WS_ENDPOINT = import.meta.env.VITE_BASE_WS_URL;
const API_ENDPOINT = import.meta.env.VITE_BASE_URL;

const GlobalStateProvider = ({ children }) => {
	// Auth
	const [user, setUser] = React.useState(null);
	const [token, setToken] = React.useState(
		localStorage.getItem("access_token")
	);

	const axiosIns = useMemo(() => {
		const axiosIns = axios.create({
			baseURL: API_ENDPOINT,
			headers: {
				Authorization: token,
			},
		});
		axiosIns.interceptors.response.use((resp) => {
			if (resp.status >= 200 && resp.status < 300) {
				return resp.data;
			} else throw resp;
		});
		return axiosIns;
	}, [token]);

	const useAxios = useMemo(() => {
		return makeUseAxios({ axios: axiosIns });
	}, [axiosIns]);

	const [getCurrentUserResult, execGetCurrentUser] = useAxios(
		{
			url: "/auths",
			method: "GET",
			headers: {
				Authorization: token,
			},
		},
		{
			manual: true,
		}
	);

	useEffect(() => {
		if (token) {
			execGetCurrentUser();
			localStorage.setItem("access_token", token);
		} else {
			localStorage.removeItem("access_token");
		}
	}, [token, execGetCurrentUser]);

	useEffect(() => {
		getCurrentUserResult.data && setUser(getCurrentUserResult.data);
	}, [getCurrentUserResult.data]);

	useEffect(() => {
		getCurrentUserResult.error && setToken(null);
	}, [getCurrentUserResult.error]);

	const register = useCallback(
		(email, password) => {
			return axiosIns
				.post("/auths/register", { email, password })
				.then((resp) => setToken(resp.data["access_token"]));
		},
		[setToken, axiosIns]
	);
	const login = useCallback(
		(email, password) => {
			return axiosIns
				.post("/auths/login", { email, password })
				.then((resp) => setToken(resp.data["access_token"]))
				.catch((err) => {
					if (err?.response?.data?.errors?.includes("NoUser")) {
						return register(email, password);
					}
					throw err;
				});
		},
		[axiosIns, register, setToken]
	);

	const isLoggedin = useMemo(() => user != null, [user]);

	const logout = useCallback(() => {
		setUser(null);
		setToken(null);
	}, [setToken]);

	// Movies

	const [getMoviesResult, execGetMovies] = useAxios(
		{
			url: "/movies",
			method: "GET",
		},
		{
			useCache: true,
		}
	);

	const movies = useMemo(() => {
		return getMoviesResult.data ? getMoviesResult.data : [];
	}, [getMoviesResult.data]);

	const addMovie = useCallback(
		(youtubeUrl) => {
			return axiosIns
				.post(
					"/movies",
					{
						youtube_url: youtubeUrl,
					},
					{
						headers: {},
					}
				)
				.then((resp) => {
					execGetMovies();
					return resp;
				});
		},
		[axiosIns, execGetMovies]
	);

	// ACTION CABLE
	const actionCable = useMemo(() => {
		return token
			? createConsumer(`${WS_ENDPOINT}/cable?auth_token=${token}`)
			: null;
	}, [token]);

	useEffect(() => {
		if (actionCable) {
			return () => {
				actionCable.disconnect();
			};
		}
	}, [actionCable]);

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
					received: ({ type, data }) => {
						if (type == "new_video") {
							execGetMovies();
							toast(
								<div>
									<a className="text-blue-500">{data.uploader.email}</a> just
									share <a className="text-red-500">{data.title}</a>.
								</div>
							);
						}
					},
				}
			);

			return () => {
				subscription.unsubscribe();
			};
		}
	}, [actionCable, execGetMovies]);

	return (
		<GlobalContext.Provider
			value={{
				action: {
					notification: MySwal,
					login: {
						exec: login,
					},
					register: {
						exec: register,
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
export { GlobalStateProvider };
