import { useGlobalState } from "../hooks";
import { useForm } from "react-hook-form";
import { Link } from "react-router-dom";
import { useEffect } from "react";
function Header() {
	const { action, state } = useGlobalState();
	const { isLoggedin, user } = state;
	const { login, logout, notification } = action;

	// useEffect(() => {
	// 	if (login.loading) {
	// 		notification.showLoading();
	// 	} else {
	// 		notification.close();
	// 	}
	// }, [login.loading, notification]);

	useEffect(() => {
		if (login.error) {
			notification.fire({
				title: "Error",
				text: login.error,
				icon: "error",
			});
		}
	}, [login.error, notification]);
	
	const LoginForm = () => {
		const { register, handleSubmit } = useForm();

		const onSubmit = (data) => login.exec(data.email, data.password);

		return (
			<div className="my-auto">
				{/* <a>{JSON.stringify(formState.errors)}</a> */}
				<form
					onSubmit={handleSubmit(onSubmit)}
					className="flex flex-row gap-4 items-center"
				>
					<input
						placeholder="Email"
						className="btn border-blue-500"
						{...register("email", {
							// required: "Email is required",
							// pattern: {
							// 	value: /^\S+@\S+$/i,
							// 	message: "Invalid email format",
							// },
						})}
						title="Email"
					/>
					<input
						placeholder="Password"
						type="password"
						className="btn border-blue-500"
						{...register("password", {
							// required: "Password is required",
						})}
					/>
					<button className="btn border-blue-500" type="submit">
						Login/Register
					</button>
				</form>
			</div>
		);
	};

	const LoggedIn = () => {
		return (
			<div className="flex flex-row gap-4 items-center">
				<h5>Welcome {user.email}</h5>
				<Link className="btn border-blue-500" to={"/add-movie"}>
					Share A Movies
				</Link>
				<button className="btn border-blue-500" onClick={logout.exec}>
					Logout
				</button>
			</div>
		);
	};

	return (
		<div className="w-full border-b-2 border-blue-500">
			<div className="flex flex-row justify-between pt-8 pb-4 container px-8  mx-auto">
				<div className="flex flex-row gap-2 items-center">
					<Link className="text-6xl" to={"/"}>
						🏠
					</Link>
					<Link className="text-4xl" to={"/"}>
						Funny Movies
					</Link>
				</div>

				{isLoggedin ? <LoggedIn /> : <LoginForm />}
			</div>
		</div>
	);
}

export default Header;
