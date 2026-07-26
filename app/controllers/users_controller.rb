class UsersController < ApplicationController
  before_action :authenticate_user!

  # app/views/accounts/show.html.erb
  def show
    # admins may view other users
    # @user = User.find(params[:id])
    # users can access their own profile
    @user = current_user
    # @user = params[:id] ? User.find(params[:id]) : current_user
  end

  def edit
    # this allow users to edit themselves
    @user = current_user
  end

  def update
    @user = current_user
    update_params = user_params

    # Check if they are trying to update their password
    is_password_updating = update_params[:password].present? || update_params[:password_confirmation].present?

    if is_password_updating
      # Force rails to validate everything. Standard .update will trigger
      # Devise's built-in password length and confirmation matching validations!
      successfully_updated = @user.update(update_params)
    else
      # Remove password keys entirely if they are blank so we can
      # update fields like username/email without erroring.
      update_params.delete(:password)
      update_params.delete(:password_confirmation)

      successfully_updated = @user.update(update_params)
    end

    if successfully_updated
      # Devise automatically signs the user out after a successful password change.
      # This signs them back in seamlessly so their session doesn't break.
      bypass_sign_in(@user) if is_password_updating

      redirect_to user_path(@user), notice: "Profile updated successfully!"
    else
      if params[:action_origin] == 'edit'
        render :edit, status: :unprocessable_entity
      else
        redirect_back fallback_location: user_path(@user), alert: "Could not update profile: #{@user.errors.full_messages.to_sentence}"
      end
    end
  end

  def add_allergy
    # ind or create the allergy globally by name
    allergy = Allergy.find_or_create_by(name: allergy_params[:name].strip.downcase)

    # Link it to the user through the conditions join table if not already linked
    if current_user.allergies.include?(allergy)
      redirect_back fallback_location: root_path, alert: "You have already added this allergy."
    else
      # inserting a many-to-many relationship.
      current_user.allergies << allergy
      redirect_back fallback_location: root_path, notice: "Allergy added successfully."
    end
  end

  def remove_allergy
    # searching only inside current_user.conditions
    condition = current_user.conditions.find_by(allergy_id: params[:allergy_id])

    if condition
      # Keep a reference to the allergy before destroying the connection
      allergy = condition.allergy
      # deletes the join table
      condition.destroy

      # Check if the allergy is now an "orphan" rows.
      if allergy.users.empty?
        allergy.destroy
      end

      redirect_back fallback_location: root_path, notice: "Allergy removed."
    else
      redirect_back fallback_location: root_path, alert: "Allergy not found."
    end
  end

  def add_preference
    @user = current_user
    new_preference = params[:preference_name].to_s.strip.downcase

    if new_preference.present?
      # Grab current preferences or start fresh if nil
      current_list = @user.preferences.to_s.split(',').map(&:strip)

      # Append the new item if it doesn't already exist
      if current_list.include?(new_preference)
        flash[:alert] = "You have already added this preference."
      else
        current_list << new_preference
        @user.update(preferences: current_list.join(', '))
        flash[:notice] = "Preference added successfully."
      end
    end

    redirect_back fallback_location: root_path
  end

  def remove_preference
    @user = current_user
    to_remove = params[:preference_name].to_s.strip

    # Split text into an array, filter out the deleted preference item, and join back
    current_list = @user.preferences.to_s.split(',').map(&:strip)
    current_list.delete_if { |preference| preference.casecmp?(to_remove) }
    new_preferences_string = current_list.any? ? current_list.join(', ') : nil

    # Update column (save nil or empty string if no preferences are left)
    if @user.update(preferences: current_list.any? ? current_list.join(', ') : nil)
      flash[:notice] = "Preference removed."
    else
      flash[:alert] = "Could not update database: #{@user.errors.full_messages.to_sentence}"
    end

    redirect_back fallback_location: root_path
  end

  def add_dislike
    @user = current_user
    new_dislike = params[:dislike_name].to_s.strip.downcase

    if new_dislike.present?
      # Grab current dislike or start fresh if nil
      current_list = @user.dislikes.to_s.split(',').map(&:strip)

      # Append the new item if it doesn't already exist
      if current_list.include?(new_dislike)
        flash[:alert] = "You have already added this dislike."
      else
        current_list << new_dislike
        @user.update(dislikes: current_list.join(', '))
        flash[:notice] = "Dislike added successfully."
      end
    end

    redirect_back fallback_location: root_path
  end

  def remove_dislike
    @user = current_user
    to_remove = params[:dislike_name].to_s.strip

    # Split text into an array, filter out the deleted dislike item, and join back
    current_list = @user.dislikes.to_s.split(',').map(&:strip)
    current_list.delete_if { |dislike| dislike.casecmp?(to_remove) }
    new_preferences_string = current_list.any? ? current_list.join(', ') : nil

    # Update column (save nil or empty string if no preferences are left)
    if @user.update(dislikes: current_list.any? ? current_list.join(', ') : nil)
      flash[:notice] = "Dislike removed."
    else
      flash[:alert] = "Could not update database: #{@user.errors.full_messages.to_sentence}"
    end

    redirect_back fallback_location: root_path
  end

  private

  # Security checkpoint: Explicitly authorize fields allowed to be updated
  def user_params
    params.require(:user).permit(:username, :email, :unit_preference, :password, :password_confirmation)
  end

  def allergy_params
    params.require(:allergy).permit(:name)
  end
end
