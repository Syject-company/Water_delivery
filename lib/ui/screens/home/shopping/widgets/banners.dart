import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:water/bloc/home/shopping/banners/banners_bloc.dart';
import 'package:water/ui/shared_widgets/shimmer.dart';
import 'package:water/ui/shared_widgets/water.dart';

class Banners extends StatelessWidget {
  const Banners({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BannersBloc, BannersState>(
      builder: (_, state) {
        Widget page = _buildBannersLoader(context);
        if (state is BannersLoaded) {
          page = _buildBanners(state);
        }

        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 250),
          reverseDuration: const Duration(milliseconds: 250),
          switchInCurve: Curves.fastOutSlowIn,
          switchOutCurve: Curves.fastOutSlowIn,
          child: page,
        );
      },
    );
  }

  Widget _buildBanners(BannersLoaded state) {
    return CarouselSlider(
      options: CarouselOptions(
        aspectRatio: 1.9,
        viewportFraction: isMobile ? 0.75 : 0.5,
        spaceBetween: 12.0,
      ),
      items: state.banners.map((banner) {
        return CachedNetworkImage(
          imageUrl: banner.image,
          fadeInCurve: Curves.fastOutSlowIn,
          fadeOutCurve: Curves.fastOutSlowIn,
          fit: BoxFit.fill,
        );
      }).toList(growable: false),
    ).withPadding(6.0, 0.0, 6.0, 0.0);
  }

  Widget _buildBannersLoader(BuildContext context) {
    return ShimmerLoading(
      isLoading: true,
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(6.0, 0.0, 6.0, 0.0),
        physics: const NeverScrollableScrollPhysics(),
        scrollDirection: Axis.horizontal,
        child: SeparatedRow(
          children: [
            _buildLoadingItem(context),
            _buildLoadingItem(context),
            _buildLoadingItem(context),
            _buildLoadingItem(context),
          ],
          separator: const SizedBox.shrink(),
        ),
      ),
    );
  }

  Widget _buildLoadingItem(BuildContext context) {
    return Container(
      width: 100.w * (isMobile ? 0.75 : 0.5) - 18.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(19.0),
        gradient: RadialGradient(
          colors: [
            AppColors.white,
            AppColors.grey,
          ],
          stops: [
            0.15,
            1.0,
          ],
          radius: 1.0,
        ),
      ),
      child: AspectRatio(
        aspectRatio: 1.9,
        child: Center(
          child: Icon(
            AppIcons.placeholder,
            color: AppColors.grey,
            size: 80.0,
          ),
        ),
      ),
    ).withPadding(6.0, 0.0, 6.0, 0.0);
  }
}
