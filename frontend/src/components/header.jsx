import { useGlobalState } from "../hooks";
import { useForm } from "react-hook-form";

function Header() {
	const { action, state } = useGlobalState();
	const { isLogin, user } = state;
	const { login, logout } = action;

	const LoginForm = () => {
		const {
			register,
			handleSubmit,
			formState: { errors },
		} = useForm();

		const onSubmit = (data) => login.exec(data.email, data.password);
		return (
			<div>
				<a>{errors}</a>
				<form onSubmit={handleSubmit(onSubmit)}>
					<input {...register("email")} />
					<input {...register("password")} />
					<button type="submit">Submit</button>
				</form>
			</div>
		);
	};

	const LoggedIn = () => {
		const ShareMovie = () => {};

		<div>
			<h5>Welcome {user.email}</h5>
			<button onClick={ShareMovie}>Share A Movies</button>
			<button onClick={logout}>Logout</button>
		</div>;
	};
	return (
		<div>
			<i>H</i>
			<h5>Funny Movies</h5>

			{isLogin ? <LoggedIn /> : <LoginForm />}
		</div>
	);
}

export default Header;
