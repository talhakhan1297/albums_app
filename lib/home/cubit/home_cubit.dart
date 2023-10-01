import 'package:album_repository/album_repository.dart';
import 'package:albums/utils/helpers/api_state.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit({required AlbumRepository albumRepository})
      : _albumRepository = albumRepository,
        super(const HomeState());

  final AlbumRepository _albumRepository;

  Future<void> getAlbums() async {
    emit(
      state.copyWith(getAlbumsApiState: state.getAlbumsApiState.toLoading()),
    );

    try {
      final data = await _albumRepository.getAlbums();

      emit(
        state.copyWith(
          getAlbumsApiState: state.getAlbumsApiState.toLoaded(data: data),
        ),
      );
    } on Exception catch (e) {
      emit(
        state.copyWith(
          getAlbumsApiState: state.getAlbumsApiState.toFailure(
            error: e.toString(),
          ),
        ),
      );
    } catch (_) {
      emit(
        state.copyWith(getAlbumsApiState: state.getAlbumsApiState.toFailure()),
      );
    }
  }

  Future<void> createAlbum() async {
    emit(
      state.copyWith(
        createAlbumApiState: state.createAlbumApiState.toLoading(),
      ),
    );

    try {
      await _albumRepository.createAlbum();

      emit(
        state.copyWith(
          createAlbumApiState: state.createAlbumApiState.toLoaded(),
        ),
      );
    } on Exception catch (e) {
      emit(
        state.copyWith(
          createAlbumApiState: state.createAlbumApiState.toFailure(
            error: e.toString(),
          ),
        ),
      );
    } catch (_) {
      emit(
        state.copyWith(
          createAlbumApiState: state.createAlbumApiState.toFailure(),
        ),
      );
    }
  }

  Future<void> deleteAlbum(int id) async {
    emit(
      state.copyWith(
        deleteAlbumApiState: state.deleteAlbumApiState.toLoading(),
      ),
    );

    try {
      await _albumRepository.deleteAlbum(id);

      emit(
        state.copyWith(
          deleteAlbumApiState: state.deleteAlbumApiState.toLoaded(),
        ),
      );
    } on Exception catch (e) {
      emit(
        state.copyWith(
          deleteAlbumApiState: state.deleteAlbumApiState.toFailure(
            error: e.toString(),
          ),
        ),
      );
    } catch (_) {
      emit(
        state.copyWith(
          deleteAlbumApiState: state.deleteAlbumApiState.toFailure(),
        ),
      );
    }
  }
}
