import { useGlobalState } from "../hooks";
import { useForm } from "react-hook-form";

function AddMoviePage() {
	const { action } = useGlobalState();
	const { addMovie } = action;
	const AddMovieForm = () => {
		const {
			register,
			handleSubmit,
			// formState: { errors },
		} = useForm();

		const onSubmit = (data) => addMovie.exec(data["youtube_url"]);
		return (
			<div className="border-2 border-blue-500 min-h-48 w-fit m-auto flex items-center flex-col gap-8 p-8">
				<div className="text-3xl">Add movie</div>

				{/* <a>{errors}</a> */}
				<form
					onSubmit={handleSubmit(onSubmit)}
					className="w-fit flex flex-col gap-8"
				>
					<input
						placeholder="Youtube URl"
						className="btn border-blue-500 min-w-96"
						{...register("youtube_url")}
					/>
					<button className="btn" type="submit">
						Submit
					</button>
				</form>
			</div>
		);
	};

	return (
		<div className="m-auto my-auto">
			<AddMovieForm />
		</div>
	);
}

export default AddMoviePage;
